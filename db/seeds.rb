book_list = {
  "Crazy Rich Asians" => {
      :author_name => "Kevin Kwan"
    },
  "Origin" => {
      :author_name => "Dan Brown"
    },
  "Fear" => {
      :author_name => "Bob Woodward"
    },
  "To Kill a Mockingbird" => {
      :author_name => "Harper Lee"
    },
  "Pride and Prejudice" => {
      :author_name => "Jane Austen"
    },
  "The Alchemist" => {
      :author_name => "Paulo Coelho"
    },
}
book_list.each do |title, book_hash|
  p = Book.new
  p.title = title
  book_hash.each do |attribute, value|
      p[attribute] = value
  end
  p.save
end
