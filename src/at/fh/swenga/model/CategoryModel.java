package at.fh.swenga.model;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "category")
public class CategoryModel implements java.io.Serializable {
	
	private static final long serialVersionUID = -8730430524625557974L;

	
	@Id
	@Column(nullable = false, length = 30)
	private String name;

	
	@Column(nullable = false, length = 100)
	private String description;
	
	
	@OneToMany(mappedBy="category",fetch=FetchType.LAZY)
	private Set<TroubleTicketModel> tickets;

	
	@OneToMany(mappedBy="category",fetch=FetchType.LAZY)
	private Set<SupportModel> supports;

	
	
	public CategoryModel() {

	}

	public CategoryModel(String name, String description) {
		super();
		this.name = name;
		this.description = description;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}
	
	public void setDescription(String description) {
		this.description = description;
	}

	public Set<TroubleTicketModel> getTickets() {
		return tickets;
	}

	public void setTickets(Set<TroubleTicketModel> tickets) {
		this.tickets = tickets;
	}

	public Set<SupportModel> getSupports() {
		return supports;
	}

	public void setSupports(Set<SupportModel> supports) {
		this.supports = supports;
	}
	
	public void addTicket(TroubleTicketModel ticket) {
		if (tickets == null) {
			tickets = new HashSet<TroubleTicketModel>();
		}
		tickets.add(ticket);
	}
	
	public void addSupport(SupportModel support) {
		if (supports == null) {
			supports = new HashSet<SupportModel>();
		}
		supports.add(support);
	}
}