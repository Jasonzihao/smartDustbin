package com.hcx.bean;

import java.io.Serializable;
import java.util.Date;


public class Node implements Serializable {

    private Integer id;


    private String jingdu;


    private String weidu;

    private String status;


    private String createtime;


    private String updatetime;


    public Integer getId() {
        return id;
    }


    public void setId(Integer id) {
        this.id = id;
    }


    public String getJingdu() {
        return jingdu;
    }


    public void setJingdu(String jingdu) {
        this.jingdu = jingdu;
    }


    public String getWeidu() {
        return weidu;
    }


    public void setWeidu(String weidu) {
        this.weidu = weidu;
    }


    public String getStatus() {
        return status;
    }


    public void setStatus(String status) {
        this.status = status;
    }

    public Node() {
    }

    public Node(String jingdu, String weidu, String status) {
        this.jingdu = jingdu;
        this.weidu = weidu;
        this.status = status;
    }

    public Node(Integer id, String jingdu, String weidu, String status) {
        this.id = id;
        this.jingdu = jingdu;
        this.weidu = weidu;
        this.status = status;
    }

    public String getCreatetime() {
        return createtime;
    }


    public void setCreatetime(String createtime) {
        this.createtime = createtime;
    }


    public String getUpdatetime() {
        return updatetime;
    }


    public void setUpdatetime(String updatetime) {
        this.updatetime = updatetime;
    }

    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        Node other = (Node) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
                && (this.getJingdu() == null ? other.getJingdu() == null : this.getJingdu().equals(other.getJingdu()))
                && (this.getWeidu() == null ? other.getWeidu() == null : this.getWeidu().equals(other.getWeidu()))
                && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
                && (this.getCreatetime() == null ? other.getCreatetime() == null : this.getCreatetime().equals(other.getCreatetime()))
                && (this.getUpdatetime() == null ? other.getUpdatetime() == null : this.getUpdatetime().equals(other.getUpdatetime()));
    }

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getJingdu() == null) ? 0 : getJingdu().hashCode());
        result = prime * result + ((getWeidu() == null) ? 0 : getWeidu().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getCreatetime() == null) ? 0 : getCreatetime().hashCode());
        result = prime * result + ((getUpdatetime() == null) ? 0 : getUpdatetime().hashCode());
        return result;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", jingdu=").append(jingdu);
        sb.append(", weidu=").append(weidu);
        sb.append(", status=").append(status);
        sb.append(", createtime=").append(createtime);
        sb.append(", updatetime=").append(updatetime);
        sb.append("]");
        return sb.toString();
    }
}