import UIKit

extension UIImageView {
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else {
            debugPrint("Error: URL invalida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                debugPrint("Error al cargar la imagen: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                debugPrint("Error: respuesta de HTTP no válida")
                return
            }
            
            guard let data = data else {
                debugPrint("Error: No se recibieron datos")
                return
            }
            
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self.image = image
                } else {
                    debugPrint("Error: No se pudo crear la imagen a partir de los datos")
                }
            }
        }.resume()
    }
}

