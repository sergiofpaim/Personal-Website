# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
#   Limpar dados (opcional, útil em dev)
Comment.delete_all
Message.delete_all
Post.delete_all
Session.delete_all
User.delete_all

# ==== USERS ====

## ==== AUTHOR (fixo) ====
author = User.find_or_create_by!(nickname: "author") do |u|
  u.password = "123456"
  u.picture = "https://picsum.photos/200?random=author"
  u.role = "author"
end

admin = User.find_or_create_by!(nickname: "admin") do |u|
  u.password = "123456"
  u.picture = "https://picsum.photos/200?random=author"
  u.role = "admin"
end

## ==== Users ====
users = 5.times.map do |i|
  User.create!(
    nickname: "user#{i + 1}",
    password: "123456",
    picture: "https://picsum.photos/200?random=#{i}",
    role: [ "admin", "user" ].sample
  )
end

# inclui o author na lista geral
users << author


# inclui o admin na lista geral
users << admin

# ==== POSTS ====
posts = users.flat_map do |user|
  3.times.map do |i|
    Post.create!(
      title: "Post #{i + 1} de #{user.nickname}",
      overview: "Resumo do post #{i + 1}",
      content: "Conteúdo detalhado do post #{i + 1} do #{user.nickname}",
      tag: [ "tech", "life", "random" ].sample,
      user_id: user.id
    )
  end
end

# ==== COMMENTS ====
comments = posts.flat_map do |post|
  rand(2..5).times.map do |i|
    Comment.create!(
      content: "Comentário #{i + 1} no post #{post.id}",
      post_id: post.id,
      user_id: users.sample.id,
      comment_id: nil # ou use para replies se quiser simular thread
    )
  end
end

# ==== REPLIES (comentários aninhados) ====
comments.sample(10).each do |parent_comment|
  Comment.create!(
    content: "Resposta ao comentário #{parent_comment.id}",
    post_id: parent_comment.post_id,
    user_id: users.sample.id,
    comment_id: parent_comment.id
  )
end

# ==== MESSAGES ====
users.each do |user|
  rand(2..4).times do |i|
    Message.create!(
      content: "Mensagem #{i + 1} do #{user.nickname}",
      user_id: user.id,
      message_id: nil # pode ser usado para threads também
    )
  end
end

# ==== SESSIONS ====
users.each do |user|
  Session.create!(
    access_token: SecureRandom.hex(16),
    user_id: user.id
  )
end

puts "Seed finalizado com sucesso!"
