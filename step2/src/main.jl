using HTTP
using JSON

const ADDR = "127.0.0.1"
const PORT = 3000

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

const STATE = ["playing", "sleeping", "eating", "drinking", "outside"]

function getcat()
    breed = rand(BREEDS)
    age = rand(1:32)
    status = rand(STATE)
    return json(Dict("breed" => breed, "age" => age, "status" => state))
end

function main()
    println("Server listening on ", PORT)
    HTTP.listen(ADDR, PORT) do http::HTTP.Stream
        @show http.message
        HTTP.setstatus(http, 200)
        HTTP.setheader(http, "Content-Type" => "application/json")

        HTTP.startwrite(http)
        write(http, getcat())
    end
end

main()
