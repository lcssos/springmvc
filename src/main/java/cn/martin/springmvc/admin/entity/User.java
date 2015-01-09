package cn.martin.springmvc.admin.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "tb_user")
public class User implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3905263902790289935L;

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid")
	@Column(length = 32)
	private String id;

	@NotEmpty(message = "{user.name.null}")
//	@Pattern(regexp = "[a-zA-Z]{5,20}", message = "{user.name.illegal}")
	@Column(length = 32, nullable = false)
	private String name;

	// @Length(min = 5, max = 20, message = "{user.age.length.illegal}")
	@Column(nullable = false)
	private int age;

	@Column
//	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date birthday;

	@Column
	private boolean isIt;



	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public boolean getIsIt() {
		return isIt;
	}

	public void setIsIt(boolean isIt) {
		this.isIt = isIt;
	}
}
