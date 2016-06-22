package at.fh.swenga.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import at.fh.swenga.model.SupportModel;

@Repository
@Transactional
public interface SupportRepository extends JpaRepository<SupportModel, Integer> {
	
	public SupportModel findByUsername(String username);
	
	@Query("select count(s) from SupportModel s")
	 public int countAllSupports();

}
