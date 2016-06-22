package at.fh.swenga.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import at.fh.swenga.model.CategoryModel;

@Repository
@Transactional
public interface CategoryRepository extends JpaRepository<CategoryModel, Integer> {

	public CategoryModel findByName(String name);

	@Query("SELECT c FROM CategoryModel c WHERE c.name NOT in ('admin')")
	public List<CategoryModel> findAllByCategoryExceptAdmin();

}
