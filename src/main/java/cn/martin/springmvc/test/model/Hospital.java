package cn.martin.springmvc.test.model;

import java.util.List;

public class Hospital {
    private Long hospitalid;

    private Short category;

    private Short majorlevel;

    private Short minorlevel;

    private String name;

    private String provinceid;

    private String cityid;

    private String address;

    private String phoneno;

    private String homepage;

    private String comments;
    
    
    
    
    
    
    
    
    private String cityName;
    
    private String provinceName;
    
    private String rdpaddress;
    private String rdpuser;
    private String rdppassword;

    
    private int doctorNum;
    private List<Doctor>  doctorList ;
    
    
    
    
    
  

	public String getRdpuser() {
		return rdpuser;
	}

	public void setRdpuser(String rdpuser) {
		this.rdpuser = rdpuser;
	}

	public String getRdppassword() {
		return rdppassword;
	}

	public void setRdppassword(String rdppassword) {
		this.rdppassword = rdppassword;
	}

	public int getDoctorNum() {
		return doctorNum;
	}

	public void setDoctorNum(int doctorNum) {
		this.doctorNum = doctorNum;
	}

	public List<Doctor> getDoctorList() {
		return doctorList;
	}

	public void setDoctorList(List<Doctor> doctorList) {
		this.doctorList = doctorList;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getRdpaddress() {
		return rdpaddress;
	}

	public void setRdpaddress(String rdpaddress) {
		this.rdpaddress = rdpaddress;
	}

	public String getCityName() {
		return cityName;
	}

	public void setCityName(String cityName) {
		this.cityName = cityName;
	}

	public Long getHospitalid() {
        return hospitalid;
    }

    public void setHospitalid(Long hospitalid) {
        this.hospitalid = hospitalid;
    }

    public Short getCategory() {
        return category;
    }

    public void setCategory(Short category) {
        this.category = category;
    }

    public Short getMajorlevel() {
        return majorlevel;
    }

    public void setMajorlevel(Short majorlevel) {
        this.majorlevel = majorlevel;
    }

    public Short getMinorlevel() {
        return minorlevel;
    }

    public void setMinorlevel(Short minorlevel) {
        this.minorlevel = minorlevel;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProvinceid() {
        return provinceid;
    }

    public void setProvinceid(String provinceid) {
        this.provinceid = provinceid;
    }

    public String getCityid() {
        return cityid;
    }

    public void setCityid(String cityid) {
        this.cityid = cityid;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhoneno() {
        return phoneno;
    }

    public void setPhoneno(String phoneno) {
        this.phoneno = phoneno;
    }

    public String getHomepage() {
        return homepage;
    }

    public void setHomepage(String homepage) {
        this.homepage = homepage;
    }

    public String getComments() {
        return comments;
    }

    public void setComments(String comments) {
        this.comments = comments;
    }
}