package cn.martin.springmvc.test.model;

import java.util.Date;

public class Tbcmessage {
    private Long bcmsgid;

    private String content;

    private String submitby;

    private Date submittime;

    public Long getBcmsgid() {
        return bcmsgid;
    }

    public void setBcmsgid(Long bcmsgid) {
        this.bcmsgid = bcmsgid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSubmitby() {
        return submitby;
    }

    public void setSubmitby(String submitby) {
        this.submitby = submitby;
    }

    public Date getSubmittime() {
        return submittime;
    }

    public void setSubmittime(Date submittime) {
        this.submittime = submittime;
    }
}