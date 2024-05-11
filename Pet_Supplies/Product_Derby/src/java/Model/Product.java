/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class Product {

    private int id;
    private String type;
    private String name;
    private int qty;
    private double price;
    private String description;
    private String image;
    private String store;
    private Pet Pet;

    public Product() {

    }

    public Product(String type, String name, int qty, double price, String description, String image, Pet Pet) {
        this.type = type;
        this.name = name;
        this.qty = qty;
        this.price = price;
        this.description = description;
        this.image = image;
        this.Pet = Pet;
    }

    public Product(int id, String type, String name, int qty, double price, String description, String image, Pet Pet) {
        this.id = id;
        this.type = type;
        this.name = name;
        this.qty = qty;
        this.price = price;
        this.description = description;
        this.image = image;
        this.Pet = Pet;
    }

    public Product(int id, String type, String name, int qty, double price, String description, String image, String store, Pet Pet) {
        this.id = id;
        this.type = type;
        this.name = name;
        this.qty = qty;
        this.price = price;
        this.description = description;
        this.image = image;
        this.store = store;
        this.Pet = Pet;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getStore() {
        return store;
    }

    public void setStore(String store) {
        this.store = store;
    }

    public Pet getPet() {
        return Pet;
    }

    public void setPet(Pet Pet) {
        this.Pet = Pet;
    }

}
