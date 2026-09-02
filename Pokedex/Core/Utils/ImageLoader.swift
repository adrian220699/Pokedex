//
//  ImageLoader.swift
//  Pokedex
//
//  Created by Adrian Flores Herrera on 5/22/26.
//

import UIKit

final class ImageLoader {

    static let shared = ImageLoader()

    private init() {}

    // MARK: - Load Image

    func loadImage(
        from urlString: String,
        source : ImageSource,
        completion: @escaping (UIImage?) -> Void
    ) {

        // 1. Revisar cache primero

        if let cachedImage =
            ImageCache.shared.image(
                forKey: urlString
            ) {

            print("[\(source.description)] Imagen Desde El Cache")

            completion(cachedImage)
             
            return
        }

        // 2. Crear URL

        guard let url = URL(
            string: urlString
        ) else {

            completion(nil)

            return
        }

        // 3. Descargar imagen

        print("[\(source.description)] Descargando Imagen")

        URLSession.shared.dataTask(
            with: url
        ) { data, _, _ in

            guard let data = data,
                  let image = UIImage(data: data)
            else {

                DispatchQueue.main.async {
                    completion(nil)
                }

                return
            }

            // 4. Guardar en cache

            ImageCache.shared.save(
                image: image,
                forKey: urlString
            )

            // 5. Regresar imagen

            DispatchQueue.main.async {

                completion(image)
            }

        }.resume()
    }
}
