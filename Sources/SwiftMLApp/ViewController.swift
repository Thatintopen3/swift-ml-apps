
import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        loadModelAndPredict()
    }

    func setupUI() {
        imageView.backgroundColor = .lightGray
        resultLabel.text = "Loading ML Model..."
    }

    func loadModelAndPredict() {
        guard let modelURL = Bundle.main.url(forResource: "SentimentClassifier", withExtension: "mlmodelc") else {
            fatalError("Failed to find model file.")
        }

        do {
            let model = try VNCoreMLModel(for: SentimentClassifier(contentsOf: modelURL).model)
            let request = VNCoreMLRequest(model: model) { [weak self] request, error in
                guard let results = request.results as? [VNClassificationObservation], let topResult = results.first else {
                    self?.resultLabel.text = "Prediction failed."
                    return
                }
                DispatchQueue.main.async {
                    self?.resultLabel.text = "Sentiment: \(topResult.identifier) (\(String(format: "%.2f", topResult.confidence * 100))%)"
                }
            }

            // Simulate an image for prediction
            if let image = UIImage(named: "sample_image") {
                let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
                try handler.perform([request])
            } else {
                self.resultLabel.text = "Sample image not found."
            }

        } catch {
            resultLabel.text = "Error loading model: \(error.localizedDescription)"
        }
    }

    // Dummy CoreML Model class (replace with actual generated class from .mlmodel)
    class SentimentClassifier: MLModel {
        init(contentsOf url: URL) throws { fatalError("Not a real model") }
        override init() { fatalError("Not a real model") }
        override var model: MLModel { fatalError("Not a real model") }
    }
}
