package models;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Version;

import models.AccessToken.Lang;
import play.data.format.Formats;
import play.data.validation.Constraints;
import play.db.ebean.Model;

@Entity
@Table(name="se_user")
public class User extends Model {
	
	/**
	 * Unique version uid for serialization
	 */
	private static final long serialVersionUID = -378338424543301076L;

	@GeneratedValue
	@Column(unique=true)
	@Id
	public Integer	id; 
	
	@Column(length=254, unique=true)
	@Constraints.Email()
	public String	email;
	
	@Column(length=40)
	public String	password;
	
	@Column(length=35)
	@Constraints.MinLength(2)
	public String	firstName;
	
	@Column(length=35)
	@Constraints.MinLength(2)
	public String	lastName;
	
	@Formats.DateTime(pattern="dd/MM/yyyy")
	public Date		birthDate;
	
	@Formats.DateTime(pattern="dd/MM/yyyy")
	public Date		inscriptionDate;
	
	public boolean	isAdmin;
	
	@OneToMany(mappedBy="creator", cascade=CascadeType.ALL)
	public List<Tag>   tags;
	
	public Lang		lang;
	
    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name="profile_picture_id")
	public Image       profilePicture;

    @OneToOne(cascade=CascadeType.ALL)
    @JoinColumn(name="cover_picture_id")
	public Image       coverPicture;
    
    @Version
    Timestamp updateTime;
	
	public User(String email, String password, String firstname, String lastname) {
		this.email = email;
		this.password = Utils.Hasher.hash(password);
		this.firstName = firstname;
		this.lastName = lastname;
		this.inscriptionDate = new Date();
		this.isAdmin = false;
		this.lang = Lang.NONE;
		this.profilePicture = Image.create(null);
		this.coverPicture = Image.create(null);
	}
	
	public static Finder<Integer, User> find = new Finder<Integer, User>
	(		
			Integer.class, User.class
	);
	
	public static User create(String email, String password) {
		User newUser = new User(email, password, null, null);
		newUser.save();
		
		return newUser;
	}
	
}
