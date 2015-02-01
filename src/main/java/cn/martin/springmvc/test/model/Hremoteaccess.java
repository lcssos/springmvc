package cn.martin.springmvc.test.model;

public class Hremoteaccess {
    private Long haccessid;

    private Long hospitalid;

    private String vpnaddress;

    private String vpnuser;

    private String vpnpassword;

    private String rdpaddress;

    private String rdpuser;

    private String rdppassword;

    public Long getHaccessid() {
        return haccessid;
    }

    public void setHaccessid(Long haccessid) {
        this.haccessid = haccessid;
    }

    public Long getHospitalid() {
        return hospitalid;
    }

    public void setHospitalid(Long hospitalid) {
        this.hospitalid = hospitalid;
    }

    public String getVpnaddress() {
        return vpnaddress;
    }

    public void setVpnaddress(String vpnaddress) {
        this.vpnaddress = vpnaddress;
    }

    public String getVpnuser() {
        return vpnuser;
    }

    public void setVpnuser(String vpnuser) {
        this.vpnuser = vpnuser;
    }

    public String getVpnpassword() {
        return vpnpassword;
    }

    public void setVpnpassword(String vpnpassword) {
        this.vpnpassword = vpnpassword;
    }

    public String getRdpaddress() {
        return rdpaddress;
    }

    public void setRdpaddress(String rdpaddress) {
        this.rdpaddress = rdpaddress;
    }

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
}