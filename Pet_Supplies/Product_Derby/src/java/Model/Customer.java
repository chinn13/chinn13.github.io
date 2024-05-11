/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class Customer {

    private String cust_id;
    private String username;
    private String password;
    private String email;
    private String contact;
    private String address;

    public Customer() {
    }

    public Customer(String cust_id, String username, String email, String contact, String address) {
        this.cust_id = cust_id;
        this.username = username;
        this.email = email;
        this.contact = contact;
        this.address = address;
    }

    public Customer(String cust_id, String username, String password, String email, String contact, String address) {
        this.cust_id = cust_id;
        this.username = username;
        this.password = password;
        this.email = email;
        this.contact = contact;
        this.address = address;
    }

    public String getCust_id() {
        return cust_id;
    }

    public void setCust_id(String cust_id) {
        this.cust_id = cust_id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

}
