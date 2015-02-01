package cn.martin.springmvc.test.model;

import java.util.Date;

public class Doctor {
    private String doctorid;

    private String name;

    private String email;

    private String phoneno;

    private Date createtime;

    private String sex;

    private Date birthday;

    private String province;

    private String hospital;

    private String department;

    private Short workyear;

    private String title;

    private String speciality;

    private String license;

    private String bacctid;

    private String bacctname;

    private String bacctbranch;

    private String bacctphoneno;

    private String photourl;

//    private Long hospitalid;  ???
    private String hospitalid;

    private Long deptid;

    private Long titleid;

    private String eulaversion;

	// RID20141117141023 HuangXiang bin
    private Short status = 0;
	// RID20141117141023 HuangXiang end
    
   // XL-R3-03-3	cl	bin
    private String state ;
    // XL-R3-03-3	cl	end

    private byte[] photo;
    
    private String base64Photo;
    
    

    public String getBase64Photo() {
		return base64Photo;
	}

	public void setBase64Photo(String base64Photo) {
		this.base64Photo = base64Photo;
	}

	public String getDoctorid() {
        return doctorid;
    }

    public void setDoctorid(String doctorid) {
        this.doctorid = doctorid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getHospital() {
        return hospital;
    }

    public void setHospital(String hospital) {
        this.hospital = hospital;
    }

    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public Short getWorkyear() {
        return workyear;
    }

    public void setWorkyear(Short workyear) {
        this.workyear = workyear;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getSpeciality() {
        return speciality;
    }

    public void setSpeciality(String speciality) {
        this.speciality = speciality;
    }

    public String getLicense() {
        return license;
    }

    public void setLicense(String license) {
        this.license = license;
    }

    public String getBacctid() {
        return bacctid;
    }

    public void setBacctid(String bacctid) {
        this.bacctid = bacctid;
    }

    public String getBacctname() {
        return bacctname;
    }

    public void setBacctname(String bacctname) {
        this.bacctname = bacctname;
    }

    public String getBacctbranch() {
        return bacctbranch;
    }

    public void setBacctbranch(String bacctbranch) {
        this.bacctbranch = bacctbranch;
    }

    public String getBacctphoneno() {
        return bacctphoneno;
    }

    public void setBacctphoneno(String bacctphoneno) {
        this.bacctphoneno = bacctphoneno;
    }

    public String getPhotourl() {
        return photourl;
    }

    public void setPhotourl(String photourl) {
        this.photourl = photourl == null ? null : photourl.trim();
    }



    public String getHospitalid() {
		return hospitalid;
	}

	public void setHospitalid(String hospitalid) {
		this.hospitalid = hospitalid;
	}

	public Long getDeptid() {
        return deptid;
    }

    public void setDeptid(Long deptid) {
        this.deptid = deptid;
    }

    public Long getTitleid() {
        return titleid;
    }

    public void setTitleid(Long titleid) {
        this.titleid = titleid;
    }

    public String getEulaversion() {
        return eulaversion;
    }

    public void setEulaversion(String eulaversion) {
        this.eulaversion = eulaversion;
    }

	// RID20141117141023 HuangXiang bin
    public Short getStatus() {
        return status;
    }
	// RID20141117141023 HuangXiang end

	// RID20141117141023 HuangXiang bin
    public void setStatus(Short status) {
        this.status = status;
    }
	// RID20141117141023 HuangXiang end

    public byte[] getPhoto() {
        return photo;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    // XL-R3-03-3	cl	end
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}
	 // XL-R3-03-3	cl	end
    
    
}