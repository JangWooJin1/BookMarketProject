package dao;

import java.util.ArrayList;
import dto.Book;


public class BookRepository{
	
	private static BookRepository instance = new BookRepository();

	public static BookRepository getInstance(){
		return instance;
	} 
	
	private ArrayList<Book> listOfBooks = new ArrayList<Book>();
	
	public BookRepository() {
		
	}
	public ArrayList<Book> getAllBooks() {
		return listOfBooks;
	}

	public Book getBookById(String bookId) {
		Book bookById = null;

		for (int i = 0; i < listOfBooks.size(); i++) {
			Book book = listOfBooks.get(i);
			if (book != null && book.getBookId() != null && book.getBookId().equals(bookId)) {
				
				bookById = book;
				break;
			}
		}
		return bookById;
	}
	
	public void addBook(Book book) {
		listOfBooks.add(book);
	}
	

}
