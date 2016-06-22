package at.fh.swenga.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import at.fh.swenga.model.TroubleTicketModel;
import at.fh.swenga.model.UserModel;

@Repository
@Transactional
public interface TroubleTicketRepository extends JpaRepository<TroubleTicketModel, Integer> {

	public TroubleTicketModel findById(int id);
	
	public List<TroubleTicketModel> findByOwner(UserModel owner);
	
	public int countByOwnerAndStatus(UserModel owner, String status);
	 
	public int countByStatus(String status);

}
