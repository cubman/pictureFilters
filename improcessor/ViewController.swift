//
//  ViewController.swift
//  improcessor
//
//  Created by Илья Лошкарёв on 09.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import UIKit
import Photos


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filterButton: UIBarButtonItem!
    
    var Filters : [FilterDelegate]!
    let context = CIContext()
    
    var miniature: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.isEnabled = false
        scrollView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cameraButtonTouched(self)
        Filters = [CIColorInvertClass(), Crystallize(), CISharpenLuminance(), CIEdges()]
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(insertNewObject))
        tap.numberOfTapsRequired = 2
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    @IBAction func saveButtonTouched(_ sender: UIBarButtonItem) {
        UIImageWriteToSavedPhotosAlbum(imageView.image!, self, #selector(image(_:didFinishSavingWithError: contextInfo:)), nil)

    }
    
    @IBAction func cameraButtonTouched(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: imagePicker.sourceType)!
        
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .popover
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func filterButtonTouched(_ sender: Any) {
        
    }
    
    func insertNewObject(_ sender: Any) {
        
        let input = UIAlertController(title: "New Note", message: "", preferredStyle: .alert)
        input.addTextField {
            textField in
            textField.placeholder = "What's up?"
        }
        
        let ok = UIAlertAction(title: "OK", style: .default) {
            [weak input, weak self] action in
            if let text = input?.textFields?.first?.text {
                self?.update(with: UIImage.addText(text as NSString, inImage: (self?.imageView.image)!, atPoint: CGPoint(x:0, y: 0), textColor: UIColor.white, textFont: UIFont.boldSystemFont(ofSize: 42)))
                

                //let t =  self?.createMiniature(from: (self?.imageView.image!)!)
                //self?.update(with: im!)
                //let note = Note(content: text)
                //self?.notes.insert(note, at: 0)
                //let indexPath = IndexPath(row: 0, section: 0)
                //self?.tableView.insertRows(at: [indexPath], with: .automatic)
            } else {
                print("no valid input")
            }
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        input.addAction(cancel)
        input.addAction(ok)
        
        present(input, animated: true)
    }

    // MARK: ImageDidFinishSavingWithError
    
    func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        guard error == nil else {
            print ("saveing error")
            return
        }
        
        let alert = UIAlertController(title: "Saved", message: "Image saved to default photo album", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    // MARK: ImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true) {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: nil)
        update(with: info[UIImagePickerControllerOriginalImage] as! UIImage)
        miniature = createMiniature(from: imageView.image!)
        //filterButton.image = filter(inputImage: miniature)
    }
    
    // MARK: ScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // MARK: Image Processing
    
    func process(image: UIImage, filterName fn : FilterDelegate) {
        self.imageView.alpha = 0.1
        self.activityIndicator.startAnimating()
        self.activityIndicator.center = self.view!.center
        //self.scrollView.isUserInteractionEnabled = true
        
        DispatchQueue.global().async {
            [weak self] in
            guard let resultImage = self?.filter(inputImage: image, filt : fn)
            else {
                return
            }
            DispatchQueue.main.sync {
                [weak self] in
                self?.update(with: resultImage)
                
                self?.activityIndicator.stopAnimating()
                //self?.scrollView.isUserInteractionEnabled = true
                self?.saveButton.isEnabled = true
                UIView.animate(withDuration: 0.5) {
                    self?.imageView.alpha = 1
                }
            }
        }

    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filters" {
            if let target = segue.destination as? TableViewController {
                target.load(c: self)
            } else {
                print("123")
                print("123")
                print("123")
            }
            
            //target?. = history
        }
    }

    
    func filter(inputImage image: UIImage, filt fn : FilterDelegate) -> UIImage? {
        guard let filter = CIFilter(name: fn.getFilterName(), withInputParameters: fn.getResultSetting())
        else {
            print("Wrong filter", fn)
            return nil
        }
        return filter.apply(to: image)?.withRenderingMode(.alwaysOriginal)
    }
    
    func update(with image: UIImage) {
        scrollView.setZoomScale(scrollView.maximumZoomScale, animated: true)
        //let url = URL(fileURLWithPath: "/usr/local/lib")
        imageView.frame = CGRect(origin: CGPoint.zero, size: image.size)
        imageView.image = image
        
        miniature = createMiniature(from: image)
        //filterButton.image = filter(inputImage: miniature)
        
        scrollView.contentSize = image.size
        scrollView.minimumZoomScale = max(scrollView.frame.width  / image.size.width,
                                          scrollView.frame.height / image.size.height)
        
        scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
    }
    
    func createMiniature(from image: UIImage) -> UIImage {
        let height: CGFloat = 30
        let width = image.size.width * height / image.size.height
        
        UIGraphicsBeginImageContext( CGSize(width: width, height: height))
        imageView.image!.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}

