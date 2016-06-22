package at.fh.swenga.model;

import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;


@Entity
@Table(name = "comment")
public class CommentModel implements java.io.Serializable{

	private static final long serialVersionUID = -8730430524625557974L;

	
	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;
	

	@Column(length = 500, nullable = false)
	private String content;
	

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date date;
	
	
	@OneToOne
	private UserModel author;
	
	
	@ManyToOne(cascade = CascadeType.REFRESH)
	private TroubleTicketModel ticket;
	

	@OneToOne(cascade = CascadeType.ALL)
	private DocumentModel document;


	
	
	public CommentModel() {
		
	}

	public CommentModel(int id, String content, Date date, UserModel author) {
		super();
		this.id = id;
		this.content = content;
		this.date = date;
		this.author = author;
	}

	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}
	
	public void setDate(Date date) {
		this.date = date;
	}

	public UserModel getAuthor() {
		return author;
	}

	public void setAuthor(UserModel author) {
		this.author = author;
	}

	public TroubleTicketModel getTicket() {
		return ticket;
	}

	public void setTicket(TroubleTicketModel ticket) {
		this.ticket = ticket;
	}
	
	public DocumentModel getDocument() {
		  return document;
		 }

	public void setDocument(DocumentModel document) {
	  this.document = document;
	 }
}