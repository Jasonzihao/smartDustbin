package com.hcx.bean;

public class Rubbish {
    private Integer rubbishId;

    private Integer rubbishUserid;

    private Integer rubbishNodeid;

    private String rubbishCreatetime;

    private String rubbishUpdatetime;

    private String rubbishHumidity;

    private String rubbishCapacity;

    private String rubbishTemperature;
    private String rubbishAlcohol;

    public Rubbish(){}

    public Rubbish(Integer rubbishId, Integer rubbishNodeid, String rubbishCreatetime){
        this.rubbishUserid = rubbishId;
        this.rubbishNodeid = rubbishNodeid;
        this.rubbishCreatetime = rubbishCreatetime;
    }

    public Integer getRubbishId() {
        return rubbishId;
    }

    public Integer getRubbishNodeid() {
        return rubbishNodeid;
    }

    public String getRubbishCapacity() {
        return rubbishCapacity;
    }

    public String getRubbishTemperature() {
        return rubbishTemperature;
    }

    public String getRubbishCreatetime() {
        return rubbishCreatetime;
    }

    public Integer getRubbishUserid() {
        return rubbishUserid;
    }

    public String getRubbishHumidity() {
        return rubbishHumidity;
    }

    public String getRubbishUpdatetime() {
        return rubbishUpdatetime;
    }

    public String getRubbishAlcohol() {return rubbishAlcohol;}

    public void setRubbishCapacity(String rubbishCapacity) {
        this.rubbishCapacity = rubbishCapacity;
    }

    public void setRubbishHumidity(String rubbishHumidity) {
        this.rubbishHumidity = rubbishHumidity;
    }

    public void setRubbishTemperature(String rubbishTemperature) {
        this.rubbishTemperature = rubbishTemperature;
    }

    public void setRubbishUpdatetime(String rubbishUpdatetime) {
        this.rubbishUpdatetime = rubbishUpdatetime;
    }

    public void setRubbishId(Integer rubbishId) {
        this.rubbishId = rubbishId;
    }

    public void setRubbishUserid(Integer rubbishUserid) {
        this.rubbishUserid = rubbishUserid;
    }

    public void setRubbishCreatetime(String rubbishCreatetime) {
        this.rubbishCreatetime = rubbishCreatetime;
    }

    public void setRubbishNodeid(Integer rubbishNodeid) {
        this.rubbishNodeid = rubbishNodeid;
    }

    public void setRubbishAlcohol(String rubbishAlcohol) {this.rubbishAlcohol = rubbishAlcohol;
    }

    public String toString(){
        return "ID:" + this.rubbishId + "Capacity:" + this.rubbishCapacity;
    }

}
