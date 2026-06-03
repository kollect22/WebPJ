package model;

import java.io.Serializable;

public class Banner implements Serializable {
    private int id;
    private String img;
    private String title;
    private int status;
    private String link;


    public Banner() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getImg() { return img; }
    public void setImg(String img) { this.img = img; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
    public String getLink() { return link; }
    public void setLink(String link) { this.link = link; }
}