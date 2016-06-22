package at.fh.swenga.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import at.fh.swenga.model.DocumentModel;

public interface DocumentRepository extends JpaRepository<DocumentModel, Integer> {
	
	
}