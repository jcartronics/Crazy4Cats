# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "faker"

count = 1

10.times do
    puts "Creando Usuario #{count}"
    user = User.create!(
      name: Faker::Name.name,
      email: Faker::Internet.email,
      password: "123456",
      password_confirmation: "123456"
    )

    puts "Creando Articulo #{count}"
    article = Article.create(
        title: Faker::Lorem.sentence(word_count: 3),
        description: Faker::Lorem.paragraph(sentence_count: 2),
        user: user
    )

    # Se deshabilita la creación de imágenes para evitar el consumo de recursos en el servidor
    # puts "Agregar imagen a Articulo #{count}"
    # file = URI.open(Faker::LoremFlickr.image(size: "300x300", search_terms: ['cat']))
    # article.image.attach(io: file, filename: "article_image_#{article.id}.jpg", content_type: 'image/jpg')


    puts "Creando Comentario #{count}"
    comment = Comment.create(
        content: Faker::Lorem.paragraph(sentence_count: 2),
        user: user,
        article: article
    )

    puts "Creando Reacción #{count}"
    reaction = Reaction.create(
        user: user,
        article: article,
        kind: "like",
        reaction_type: "article"
    )

    count += 1


  end