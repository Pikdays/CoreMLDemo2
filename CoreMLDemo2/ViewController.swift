//
//  ViewController.swift
//  CoreMLDemo2
//
//  Created by Pikdays on 2021/3/21.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //
    lazy private var imageView: UIImageView = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapImage))

        let imageView = UIImageView(image: UIImage(systemName: "photo"))
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        return imageView
    }()
    
    @objc func didTapImage() {
        present(picker, animated: true)
    }
    
    //
    lazy private var label: UILabel = {
        let text = "Select Image"
        let label = UILabel()
        label.text = text
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    func changeLabelContent(_ text: String?) {
        label.text = text ?? "未知"
    }
    
    //
    lazy private var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        return picker
    }()
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        let image = info[.originalImage] as? UIImage
        
        //
        imageView.image = image
        //
        let text = image?.analyzeImage()
        changeLabelContent(text)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(label)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width-40, height: view.frame.size.width - 40)
        label.frame = CGRect(x: 20, y: view.safeAreaInsets.top + (view.frame.size.width - 40) + 10, width: view.frame.size.width-40, height: 100)
    }
}
