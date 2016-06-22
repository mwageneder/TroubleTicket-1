package at.fh.swenga.model;

import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;


@Entity
public class SupportModel extends UserModel {
	
	private static final long serialVersionUID = -8730430524625557974L;


	@ManyToOne(cascade = CascadeType.PERSIST)
	private CategoryModel category;


	
	public SupportModel() {

	}

	public SupportModel(int id, String firstname, String lastname, String username, String email, String password,
			String picture, boolean enabled, Set<UserRole> userRole) {
		super(firstname, lastname, username, email, password, picture, enabled, userRole);
	}

	public CategoryModel getCategory() {
		return category;
	}

	public void setCategory(CategoryModel category) {
		this.category = category;
	}
}