package at.fh.swenga.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import at.fh.swenga.dao.CategoryRepository;
import at.fh.swenga.dao.CommentRepository;
import at.fh.swenga.dao.DocumentRepository;
import at.fh.swenga.dao.SupportRepository;
import at.fh.swenga.dao.TroubleTicketRepository;
import at.fh.swenga.dao.UserRepository;
import at.fh.swenga.dao.UserRoleRepository;
import at.fh.swenga.model.CategoryModel;
import at.fh.swenga.model.CommentModel;
import at.fh.swenga.model.DocumentModel;
import at.fh.swenga.model.SupportModel;
import at.fh.swenga.model.TroubleTicketModel;
import at.fh.swenga.model.UserModel;
import at.fh.swenga.model.UserRole;

@Controller
public class MainController {

	@Autowired
	CommentRepository commentRepository;

	@Autowired
	TroubleTicketRepository troubleTicketRepository;

	@Autowired
	UserRepository userRepository;

	@Autowired
	CategoryRepository categoryRepository;

	@Autowired
	UserRoleRepository userRoleRepository;

	@Autowired
	SupportRepository supportRepository;

	@Autowired
	DocumentRepository documentRepository;

	@Autowired
	private MailSender mailSender;

	@Autowired
	private SimpleMailMessage templateMessage;

	@RequestMapping(value = { "/supportHome", "supportHome" })
	public String indexSupport(Model model) {
		String currentUsername = getCurrentUser(model);
		SupportModel currentSupport = supportRepository.findByUsername(currentUsername);

		int openTT = troubleTicketRepository.countByStatus("Open");
		model.addAttribute("openTT", openTT);

		int managedTT = troubleTicketRepository.countByStatus("Managed");
		model.addAttribute("managedTT", managedTT);

		int closedTT = troubleTicketRepository.countByStatus("Closed");
		model.addAttribute("closedTT", closedTT);

		int supportUsers = supportRepository.countAllSupports();
		model.addAttribute("supportUsers", supportUsers);

		int users = userRepository.countAllUsers();
		model.addAttribute("users", users);

		int comments = commentRepository.countAllCommentsFromSupportsManagedTickets(currentSupport);
		model.addAttribute("comments", comments);

		return "home";
	}

	@RequestMapping(value = { "/userHome", "userHome" })
	public String indexUser(Model model) {
		String currentUsername = getCurrentUser(model);
		UserModel currentUser = userRepository.findByUsername(currentUsername);

		int openTT = troubleTicketRepository.countByOwnerAndStatus(currentUser, "Open");
		model.addAttribute("openTT", openTT);

		int managedTT = troubleTicketRepository.countByOwnerAndStatus(currentUser, "Managed");
		model.addAttribute("managedTT", managedTT);

		int closedTT = troubleTicketRepository.countByOwnerAndStatus(currentUser, "Closed");
		model.addAttribute("closedTT", closedTT);

		int supportUsers = supportRepository.countAllSupports();
		model.addAttribute("supportUsers", supportUsers);

		int users = userRepository.countAllUsers();
		model.addAttribute("users", users);

		int comments = commentRepository.countAllCommentsFromUsersTickets(currentUser);
		model.addAttribute("comments", comments);

		return "userHome";
	}

	@RequestMapping(value = { "/dashboard", "dashboard" })
	public String dashboard(Model model) {

		List<TroubleTicketModel> troubleTickets = new ArrayList<TroubleTicketModel>();
		String currentUser = getCurrentUser(model);
		UserModel user = userRepository.findByUsername(currentUser);
		UserRole role = userRoleRepository.findByUserWithRoleUser(user);

		if (role != null) {
			troubleTickets = troubleTicketRepository.findByOwner(user);
		} else {
			troubleTickets = troubleTicketRepository.findAll();
		}

		model.addAttribute("troubleTickets", troubleTickets);

		return "dashboard";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String handleLogin() {
		return "login";
	}

	@RequestMapping(value = { "/signUp", "signUp" })
	public String signUp(Model model) {
		return "signUp";
	}

	@RequestMapping(value = { "/createUser", "createUser" })
	public String createUser(Model model) {
		getCurrentUser(model);
		return "addUser";
	}

	@RequestMapping(value = { "/createSupport", "createSupport" })
	public String createSupport(Model model) {

		List<CategoryModel> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		getCurrentUser(model);

		return "addSupport";
	}

	@Transactional
	@RequestMapping(value = "/registerUser", method = RequestMethod.POST)
	public String registerUser(@Valid @ModelAttribute UserModel newUser, Model model) {

		UserModel user = userRepository.findByUsername(newUser.getUsername());

		if (user != null) {
			model.addAttribute("message", "User already exists!");
		} else {

			UserRole role = new UserRole("ROLE_USER", newUser);

			newUser.setPassword(passwordEncoder(newUser.getPassword()));
			newUser.setPicture("resources/images/UserIcon.png");
			newUser.setEnabled(true);

			userRepository.save(newUser);
			userRoleRepository.save(role);
			model.addAttribute("message", "New user added!");

			sendMail(newUser, "registerUser", "");
		}

		return "login";
	}

	@Transactional
	@RequestMapping(value = "/addUser", method = RequestMethod.POST)
	public String addUser(@Valid @ModelAttribute UserModel newUser, Model model) {

		UserModel user = userRepository.findByUsername(newUser.getUsername());
		getCurrentUser(model);

		if (user != null) {
			model.addAttribute("message", "User already exists!");
		} else {

			sendMail(newUser, "newUser", newUser.getPassword());
			UserRole role = new UserRole("ROLE_USER", newUser);
			newUser.setPassword(passwordEncoder(newUser.getPassword()));
			newUser.setPicture("resources/images/UserIcon.png");
			newUser.setEnabled(true);
			userRepository.save(newUser);
			userRoleRepository.save(role);
			model.addAttribute("successMessage", " User  [" + newUser.getUsername() + "] successfully created!");
		}

		return "dashboard";
	}

	@Transactional
	@RequestMapping(value = "/addSupport", method = RequestMethod.POST)
	public String addSupport(@RequestParam String username, @RequestParam String firstName,
			@RequestParam String lastName, @RequestParam String email, @RequestParam String category,
			@RequestParam String password, @RequestParam String role, Model model) {

		SupportModel support = supportRepository.findByUsername(username);
		getCurrentUser(model);

		if (support != null) {
			model.addAttribute("message", "User already exists!");
		} else {

			SupportModel newSupport = new SupportModel();
			UserRole newRole = new UserRole(role, newSupport);

			newSupport.setUsername(username);
			newSupport.setFirstName(firstName);
			newSupport.setLastName(lastName);
			newSupport.setEmail(email);
			newSupport.setCategory(categoryRepository.findByName(category));
			newSupport.setEnabled(true);
			newSupport.setPicture("resources/images/UserIcon.png");
			newSupport.setPassword(passwordEncoder(password));

			sendMail((UserModel) newSupport, "newUser", password);

			supportRepository.save(newSupport);
			userRoleRepository.save(newRole);

			model.addAttribute("successMessage", " User  [" + newSupport.getUsername() + "] successfully created!");
		}

		return "dashboard";
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.GET)
	public String editUser(Model model) {

		UserModel currentUser = userRepository.findByUsername(getCurrentUser(model));
		List<CategoryModel> categories = categoryRepository.findAll();

		model.addAttribute("categories", categories);
		model.addAttribute("user", currentUser);

		return "editUser";
	}

	@RequestMapping(value = "/editUser", method = RequestMethod.POST)
	public String editUser(@RequestParam String username, @RequestParam String firstName, @RequestParam String lastName,
			@RequestParam String email, @RequestParam String password, Model model) {

		UserModel user = userRepository.findByUsername(username);

		user.setFirstName(firstName);
		user.setLastName(lastName);
		user.setEmail(email);
		user.setPassword(passwordEncoder(password));
		userRepository.save(user);

		model.addAttribute("successMessage",
				" EDIT was successful for User with Username [" + user.getUsername() + "].");

		return dashboard(model);
	}

	@RequestMapping(value = { "/createTicket", "createTicket" })
	public String createTicket(Model model) {

		List<CategoryModel> categories = categoryRepository.findAllByCategoryExceptAdmin();
		model.addAttribute("categories", categories);

		List<UserModel> users = userRepository.findAll();
		model.addAttribute("users", users);

		getCurrentUser(model);

		return "addTicket";
	}

	@RequestMapping(value = "/addTicket", method = RequestMethod.POST)
	public String addTicket(@RequestParam String owner, @RequestParam String subject, @RequestParam String description,
			@RequestParam int priority, @RequestParam String category, Model model) {

		TroubleTicketModel newTicket = new TroubleTicketModel();
		Date date = new Date();

		newTicket.setCategory(categoryRepository.findByName(category));
		newTicket.setOwner(userRepository.findByUsername(owner));
		newTicket.setDescription(description);
		newTicket.setSubject(subject);
		newTicket.setPriority(priority);
		newTicket.setDatecreated(date);
		newTicket.setDatemodified(date);
		newTicket.setStatus("Open");

		troubleTicketRepository.save(newTicket);

		return dashboard(model);
	}

	@RequestMapping(value = "/editTicket", method = RequestMethod.GET)
	public String editTicket(Model model, @RequestParam int id) {

		TroubleTicketModel ticket = troubleTicketRepository.findById(id);

		if (ticket != null && troubleTicketRepository.findById(id).getStatus().equals("Closed")) {
			model.addAttribute("message", "The ticket with ID [" + ticket.getId() + "] is CLOSED and can't be edited!");

			return dashboard(model);

		} else {
			List<CategoryModel> categories = categoryRepository.findAllByCategoryExceptAdmin();

			model.addAttribute("categories", categories);
			model.addAttribute("ticket", ticket);
			getCurrentUser(model);

			return "editTicket";
		}
	}

	@RequestMapping(value = "/editTicket", method = RequestMethod.POST)
	public String editTicket(Integer id, @RequestParam String subject, @RequestParam String category,
			@RequestParam Integer priority, Model model) {

		TroubleTicketModel ticket = troubleTicketRepository.findById(id);
		Date date = new Date();

		ticket.setCategory(categoryRepository.findByName(category));
		ticket.setSubject(subject);
		ticket.setDatemodified(date);
		ticket.setPriority(priority);
		troubleTicketRepository.save(ticket);

		model.addAttribute("successMessage", " EDIT was successful for ticket with ID [" + ticket.getId() + "].");

		return dashboard(model);
	}

	@RequestMapping(value = "/closeTicket", method = RequestMethod.POST)
	public String closeTicket(@RequestParam int id, @RequestParam String closingReason, Model model) {

		TroubleTicketModel ticket = troubleTicketRepository.findById(id);
		Date date = new Date();

		if (ticket.getStatus().equals("Closed")) {
			model.addAttribute("message", " The ticket with ID [" + ticket.getId() + "] is already CLOSED.");

			return dashboard(model);
		} else {
			ticket.setClosingReason(closingReason);
			ticket.setDateclosed(date);
			ticket.setStatus("Closed");
			ticket.setPriority(0);

			troubleTicketRepository.save(ticket);
			model.addAttribute("successMessage",
					" The ticket with ID [" + ticket.getId() + "] was successfully CLOSED.");

			return dashboard(model);
		}
	}

	@RequestMapping("/manageTicket")
	public String manageTicket(@RequestParam int id, Model model) {

		TroubleTicketModel ticket = troubleTicketRepository.findById(id);
		SupportModel currentUser = supportRepository.findByUsername(getCurrentUser(model));
		Date date = new Date();

		ticket.setSupport(currentUser);
		ticket.setStatus("Managed");
		ticket.setDatemodified(date);
		troubleTicketRepository.save(ticket);

		return showComments(id, model);
	}

	@RequestMapping("/unmanageTicket")
	public String unmanageTicket(@RequestParam int id, Model model) {

		TroubleTicketModel ticket = troubleTicketRepository.findById(id);
		Date date = new Date();

		ticket.setSupport(null);
		ticket.setStatus("Open");
		ticket.setDatemodified(date);
		troubleTicketRepository.save(ticket);

		return showComments(id, model);
	}

	@RequestMapping(value = { "/commentTicket", "commentTicket" })
	public String commentTicket(int id, Model model) {
		List<CommentModel> comments = commentRepository.findAll();
		model.addAttribute("comments", comments);
		TroubleTicketModel ticket = troubleTicketRepository.findById(id);
		model.addAttribute("ticket", ticket);
		getCurrentUser(model);
		return "addComment";
	}

	@RequestMapping(value = "/editPicture", method = RequestMethod.GET)
	public String editPicture(Model model) {
		getCurrentUser(model);
		return "editPicture";
	}

	@RequestMapping(value = "/editPicture", method = RequestMethod.POST)
	public String editPicture(Model model, @RequestParam("image") MultipartFile file) {
		UserModel user = userRepository.findByUsername(getCurrentUser(model));

		if (!file.isEmpty()) {
			try {
				byte[] bytes = file.getBytes();

				// Creating the directory to store file
				// C:\Program Files\Java\apache-tomcat-8.0.32
				String rootPath = System.getProperty("catalina.home");

				File dir = new File(rootPath + File.separator + "tmpFiles");

				if (!dir.exists())
					dir.mkdirs();

				// Create the file on server
				File serverFile = new File(dir.getAbsolutePath() + File.separator + file.getOriginalFilename());
				BufferedOutputStream stream = new BufferedOutputStream(new FileOutputStream(serverFile));
				stream.write(bytes);
				stream.close();

				user.setPicture(rootPath + File.separator + "tmpFiles" + File.separator + file.getOriginalFilename());
				userRepository.save(user);

			} catch (Exception e) {
			}
		}

		getCurrentUser(model);
		return "dashboard";
	}

	@RequestMapping(value = { "/showComments", "showComments" })
	public String showComments(int id, Model model) {
		List<CategoryModel> categories = categoryRepository.findAll();
		model.addAttribute("categories", categories);
		List<UserModel> users = userRepository.findAll();
		model.addAttribute("users", users);
		TroubleTicketModel ticket = troubleTicketRepository.findById(id);
		model.addAttribute("ticket", ticket);
		List<CommentModel> comments = commentRepository.findByTicket(ticket);
		model.addAttribute("comments", comments);
		String user = getCurrentUser(model);

		if (userRoleRepository.findByUserWithRoleUser(userRepository.findByUsername(user)) == null) {
			CategoryModel supportCat = supportRepository.findByUsername(user).getCategory();
			model.addAttribute("supportCat", supportCat);
		}

		return "commentTicket";
	}

	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
	public String addComment(@RequestParam String content, Model model, int id,
			@RequestParam("myFile") MultipartFile file) {

		UserModel currentUser = userRepository.findByUsername(getCurrentUser(model));
		CommentModel newComment = new CommentModel();
		Date date = new Date();

		newComment.setContent(content);
		newComment.setDate(date);
		newComment.setAuthor(currentUser);
		newComment.setTicket(troubleTicketRepository.findById(id));
		commentRepository.save(newComment);

		try {

			DocumentModel newdocument = new DocumentModel();
			newdocument.setContent(file.getBytes());
			newdocument.setContentType(file.getContentType());
			newdocument.setCreated(new Date());
			newdocument.setFilename(file.getOriginalFilename());
			newdocument.setName(file.getName());
			documentRepository.save(newdocument);
			newComment.setDocument(newdocument);
			commentRepository.save(newComment);
			sendMail(troubleTicketRepository.findById(id).getOwner(), "newComment", "" + id);
		} catch (Exception e) {
			model.addAttribute("errorMessage", "Error:" + e.getMessage());
		}

		return showComments(id, model);

	}

	@RequestMapping("/download")
	public void download(@RequestParam("documentId") int documentId, HttpServletResponse response) {
		DocumentModel doc = documentRepository.findOne(documentId);

		try {
			response.setHeader("Content-Disposition", "inline;filename=\"" + doc.getFilename() + "\"");
			OutputStream out = response.getOutputStream();
			response.setContentType(doc.getContentType());
			out.write(doc.getContent());
			out.flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void sendMail(UserModel user, String type, String addon) {

		String toUser = user.getFirstName() + " " + user.getLastName();
		SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
		msg.setTo(user.getEmail());

		if (type.equals("registerUser")) {
			String username = "Username: " + user.getUsername();
			msg.setSubject("Your new user account!");
			msg.setText(String.format(msg.getText(), toUser, "Your new user account was created!\n" + username));

		} else if (type.equals("newUser")) {
			String username = "Username: " + user.getUsername();
			msg.setSubject("A user account was created for you!");
			msg.setText(String.format(msg.getText(), toUser, "Your new user account was created!\n" + username
					+ "\nPassword: " + addon + "\nPlease change your password!"));

		} else if (type.equals("newComment")) {
			msg.setSubject("New Comment on your ticket!");
			msg.setText(String.format(msg.getText(), toUser,
					"A new comment was added to your ticket!\nTicket ID: " + addon));
		}

		try {
			this.mailSender.send(msg);
		} catch (MailException ex) {
			ex.printStackTrace();
		}
	}

	public String passwordEncoder(String password) {
		PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		String hashedPassword = passwordEncoder.encode(password);

		return hashedPassword;
	}

	public String getCurrentUser(Model model) {
		final UserDetails userdetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication()
				.getPrincipal();
		String username = userdetails.getUsername();

		UserModel user = userRepository.findByUsername(username);
		model.addAttribute("user", user);
		return username;
	}

	@ExceptionHandler(Exception.class)
	public String handleAllException(Exception ex) {
		return "showError";
	}
}
