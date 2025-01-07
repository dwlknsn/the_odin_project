// Book constructor
function Book(title, author, pageCount, readStatus) {
  this.title = title;
  this.author = author;
  this.pageCount = pageCount;
  this.readStatus = readStatus;
  this.id = stringToHash(this.title);
  this.info = function(){
    return `${this.title} by ${this.author}, ${this.pageCount} pages, ${readStatus ? "already read" : "not read yet"}`
  }
  this.toggleReadStatus = function() {
    this.readStatus = !this.readStatus;
  }
}

// Generating unique IDs based on book title
// This allows us to add and remove elements in the UI, and also in the myLibrary.books collection
// without needing to rely on the index of the book, which would change each time we remove elements.
function stringToHash(string) {
  let hash = 0;
  if (string.length == 0) return hash;
  for (let i = 0; i < string.length; i++) {
      const char = string.charCodeAt(i);
      hash = ((hash << 5) - hash) + char;
      hash = hash & hash;
  }
  return hash;
}

// Library constructor
function Library(books = []) {
  this.books = books;
  this.addBook = function(book) {
    return this.books.push(book);
  }
  this.removeBook = function(id) {
    const index = this.books.map((book) => { return book.id }).indexOf(id);
    return this.books.splice(index, 1);
  }
  this.findBook = function(id) {
    return this.books.find((element) => element.id == id );
  }
}

// // // // // // // // // //
// Functionality for Adding Books
// // // // // // // // // //

function createBook(title, author, pageCount, readStatus) {
  const book = new Book(title, author, pageCount, readStatus);
  myLibrary.addBook(book);
  addBookToUI(book);
}

const bookshelf = document.querySelector("#bookshelf")
const bookTemplate = document.querySelector("#book-template")

function addBookToUI(book) {
  const newCard = bookTemplate.content.cloneNode(true);
  newCard.querySelector(".book-title").textContent = book.title;
  newCard.querySelector(".book-author").textContent = book.author;
  newCard.querySelector(".book-page-count").textContent = `${book.pageCount} Pages`;
  newCard.querySelector(".book-read-status").textContent = `${book.readStatus ? "already read" : "not read yet"}`;
  if (book.readStatus) { newCard.querySelector(".card").classList.add("read"); }
  newCard.querySelector(".card").id = `book-${book.id}`;

  bookshelf.appendChild(newCard);

  // Set data attributes for future interactions
  const card = document.querySelector(`#book-${book.id}`);
  const buttons = card.querySelectorAll("button")
  buttons.forEach((button) => { button.dataset.bookId = book.id; })

  // Add event listeners when constructing, so that new book elements added via
  // the form also have the interactive functionality
  const removeBookButton = card.querySelector(".remove-book")
  removeBookButton.addEventListener("click", (event) => {
    event.preventDefault();
    deleteBook(book.id);
  });

  const toggleReadStatusButton = card.querySelector(".toggle-read-status")
  toggleReadStatusButton.addEventListener("click", (event) => {
    event.preventDefault();
    toggleReadStatus(book.id);
  });
}

const newBookFormContainer = document.querySelector("#new-book-form-container")

function toggleFormVisibility(){
  newBookFormContainer.classList.toggle("hidden");
  showBookFormButton.classList.toggle("hidden");
}


// // // // // // // // // //
// Functionality for Removing Books
// // // // // // // // // //

function deleteBook(id) {
  myLibrary.removeBook(id);
  removeBookFromUI(id)
}

function removeBookFromUI(id) {
  const element = bookshelf.querySelector(`#book-${id}`);
  element.remove()
}

// // // // // // // // // //
// Functionality for toggling read status
// // // // // // // // // //

function toggleReadStatus(id) {
  const book = myLibrary.findBook(id);
  book.toggleReadStatus()

  const bookCard = bookshelf.querySelector(`#book-${id}`);
  bookCard.classList.toggle("read");
  bookCard.querySelector(".book-read-status").textContent = `${book.readStatus ? "already read" : "not read yet"}`;
}


// // // // // // // // // //
// Seeding Data
// // // // // // // // // //

const myLibrary = new Library;

const bookData = [
  ["The Hobbit", "J.R.R. Tolkien", 295, false],
  ["DCC #1 - Dungeon Crawler Carl", "Matt Dinniman", 446, true],
  ["DCC #2 - Carl's Doomsday Scenario", "Matt Dinniman", 364, true],
  ["DCC #3 - The Dungeon Anarchist's Cookbook", "Matt Dinniman", 534, true],
  ["DCC #4 - The Gate of the Feral Gods", "Matt Dinniman", 632, true],
  ["DCC #5 - The Butcher's Masquerade", "Matt Dinniman", 726, true],
  ["DCC #6 - The Eye of the Bedlam Bride", "Matt Dinniman", 694, true],
  ["DCC #7 - This Inevitable Ruin", "Matt Dinniman", 724, false],
]

bookData.forEach((element) => { createBook(element[0], element[1], element[2], element[3]); });


// // // // // // // // // //
// Event listeners
// // // // // // // // // //

const showBookFormButton = document.querySelector("#show-book-form-button")

showBookFormButton.addEventListener("click", (event) => {
  event.preventDefault;
  toggleFormVisibility();
})

const newBookForm = document.querySelector("#new-book-form")

newBookForm.addEventListener("submit", (event) => {
  event.preventDefault();
  const formData = new FormData(newBookForm);
  createBook(...formData.values());
  newBookForm.reset();
  toggleFormVisibility();
})
