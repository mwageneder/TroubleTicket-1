package at.fh.swenga.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;

@Entity
@Table(name = "troubleTicket")
public class TroubleTicketModel implements java.io.Serializable {

	private static final long serialVersionUID = -8730430524625557974L;

	@Id
	@Column(name = "id")
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private int id;

	@Column(length = 30, nullable = false)
	private String subject;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date datecreated;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(nullable = false)
	private Date datemodified;

	@Temporal(TemporalType.TIMESTAMP)
	private Date dateclosed;

	@Column(length = 10, nullable = false)
	private String status;

	@Column(length = 100)
	private String closingReason;

	@Column(length = 1000, nullable = false)
	private String description;

	@Min(0)
	@Max(10)
	@Column(nullable = false)
	private int priority;

	@ManyToOne(cascade = CascadeType.REFRESH)
	private SupportModel support;

	@ManyToOne(cascade = CascadeType.REFRESH)
	private UserModel owner;

	@ManyToOne(cascade = CascadeType.REFRESH)
	private CategoryModel category;

	@OneToMany(mappedBy = "ticket", fetch = FetchType.EAGER)
	private Set<CommentModel> comments;

	public TroubleTicketModel() {

	}

	public TroubleTicketModel(String subject, String description, UserModel owner, CategoryModel category,
			int priority, String closingReason) {
		super();
		this.subject = subject;
		this.description = description;
		this.owner = owner;
		this.category = category;
		this.priority = priority;
		this.closingReason = closingReason;
	}

	public TroubleTicketModel(String subject, Date datecreated, Date datemodified, Date dateclosed, String status,
			String description, int priority, String closingReason) {
		super();
		this.subject = subject;
		this.datecreated = datecreated;
		this.datemodified = datemodified;
		this.dateclosed = dateclosed;
		this.status = status;
		this.description = description;
		this.priority = priority;
		this.closingReason = closingReason;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public Date getDatecreated() {
		return datecreated;
	}

	public void setDatecreated(Date datecreated) {
		this.datecreated = datecreated;
	}

	public Date getDatemodified() {
		return datemodified;
	}

	public void setDatemodified(Date datemodified) {
		this.datemodified = datemodified;
	}

	public Date getDateclosed() {
		return dateclosed;
	}

	public void setDateclosed(Date dateclosed) {
		this.dateclosed = dateclosed;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int getPriority() {
		return priority;
	}

	public void setPriority(int priority) {
		this.priority = priority;
	}

	public SupportModel getSupport() {
		return support;
	}

	public void setSupport(SupportModel support) {
		this.support = support;
	}

	public UserModel getOwner() {
		return owner;
	}

	public void setOwner(UserModel owner) {
		this.owner = owner;
	}

	public CategoryModel getCategory() {
		return category;
	}

	public void setCategory(CategoryModel category) {
		this.category = category;
	}

	public Set<CommentModel> getComments() {
		return comments;
	}

	public void setComments(Set<CommentModel> comments) {
		this.comments = comments;
	}

	public String getClosingReason() {
		return closingReason;
	}

	public void setClosingReason(String closingReason) {
		this.closingReason = closingReason;
	}

	public void addComment(CommentModel comment) {
		if (comments == null) {
			comments = new HashSet<CommentModel>();
		}
		comments.add(comment);
	}
}