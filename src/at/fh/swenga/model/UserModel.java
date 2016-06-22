package at.fh.swenga.model;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Version;

@Entity
@Table(name = "user")
public class UserModel implements java.io.Serializable {
	
	private static final long serialVersionUID = -8730430524625557974L;


	@Id
	@Column(length = 30, unique = true, nullable = false)
	private String username;
	
	
	@Column(nullable = false, length = 30)
	private String firstName;
	
	
	@Column(nullable = false, length = 30)
	private String lastName;
	
	
	@Column(nullable = false, length = 80)
	private String email;
	
	
	@Column(nullable = false)
	private String password;
	
	
	@Column(nullable = false)
	private String picture;
	
	
	@Column(name = "enabled", nullable = false)
	private boolean enabled;
	
	
	@Version
	long version;
	

	@OneToMany(mappedBy="owner",fetch=FetchType.LAZY)
	private Set<TroubleTicketModel> tickets;
	
	
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "user")
	private Set<UserRole> userRoles = new HashSet<UserRole>(0);

	
	
	public UserModel(){
		
	}

	
	public UserModel(String firstName, String lastName, String username, String email, String password, String picture, boolean enabled,
			Set<UserRole> userRoles){
		super();
		this.firstName = firstName;
		this.lastName = lastName;
		this.username = username;
		this.email = email;
		this.password = password;
		this.picture = picture;
		this.enabled = enabled;
		this.userRoles = userRoles;
	}
	
	
	public String getFirstName() {
		return firstName;
	}
	
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}
	
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getUsername() {
		return username;
	}
	
	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}

	public String getPicture() {
		return picture;
	}
	
	public void setPicture(String picture) {
		this.picture = picture;
	}
	
	public Set<TroubleTicketModel> getTickets() {
		return tickets;
	}

	public void setTickets(Set<TroubleTicketModel> tickets) {
		this.tickets = tickets;
	}
	
	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public Set<UserRole> getUserRole() {
		return userRoles;
	}

	public void setUserRole(Set<UserRole> userRoles) {
		this.userRoles = userRoles;
	}
	
	public void addTicket(TroubleTicketModel ticket) {
		if (tickets == null) {
			tickets = new HashSet<TroubleTicketModel>();
		}
		tickets.add(ticket);
	}
}