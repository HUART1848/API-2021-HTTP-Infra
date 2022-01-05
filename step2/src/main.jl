using HTTP
using JSON

# Constantes
const ADDR = "0.0.0.0"
const PORT = 3000

const MAX_CATS = 10

const BREEDS = ["Abyssinian",
    "Australian Mist", "Balinese",
    "Bengal", "Birman",
    "Bombay", "British Shorthair",
    "Burmese", "Burmilla",
    "Cornish Rex", "Devon Rex",
    "Egyptian Mau", "Exotic Shorthair",
    "Japanese Bobtail", "Korat",
    "La Perms", "Maine Coon",
    "Manx", "Norwegian Forest",
    "Ocicat", "Oriental Shorthair",
    "Persian Longhair", "Ragdoll",
    "Russian Blue", "Scottish Fold",
    "Siamese", "Siberian Forest",
    "Singapura", "Snowshoe",
    "Somali", "Sphynx",
    "Tiffanie", "Tonkinese",
    "Turkish Van"]
const STATUSES = ["playing", "sleeping", "eating", "drinking", "outside", "unknown"]


"Génère et retourne un chat"
function getcat(agemax=24)
    return Dict("breed" => rand(BREEDS),
                "age" => string(rand(1:agemax)),
                "status" => rand(STATUSES))
end

"Retourne `n` chats sous forme JSON"
function getcats(n, agemax=24)
    return json([getcat() for i in 1:n])
end
 
"Lance le serveur et écoute sur le port (3000 par défaut)"
function main()
    println("Server listening on port ", PORT)
    HTTP.listen(ADDR, PORT) do http::HTTP.Stream
        HTTP.setstatus(http, 200)
        HTTP.setheader(http, "Content-Type" => "application/json")

        HTTP.startwrite(http)
        write(http, getcats(rand(1:MAX_CATS)))
        HTTP.closewrite(http)
    end
end

main()
