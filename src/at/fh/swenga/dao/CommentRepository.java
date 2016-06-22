package at.fh.swenga.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import at.fh.swenga.model.CommentModel;
import at.fh.swenga.model.SupportModel;
import at.fh.swenga.model.TroubleTicketModel;
import at.fh.swenga.model.UserModel;

@Repository
@Transactional
public interface CommentRepository extends JpaRepository<CommentModel, Integer> {

	public CommentModel findById(int id);

	public List<CommentModel> findByTicket(TroubleTicketModel ticket);

	@Query("select count(c) from CommentModel c where ticket in (select id from TroubleTicketModel t where owner = :owner)")
	public int countAllCommentsFromUsersTickets(@Param("owner") UserModel owner);

	@Query("select count(c) from CommentModel c where ticket in (select id from TroubleTicketModel t where support = :support)")
	public int countAllCommentsFromSupportsManagedTickets(@Param("support") SupportModel support);

}
