/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

public class User {

    private int user_id;
    private String position;
    private Staff staff;
    private Customer customer;

    public User() {
    }

    public User(int user_id) {
        this.user_id = user_id;
    }

    public User(Customer cust) {
        this.customer = cust;
    }

    public User(int user_id, Staff staff) {
        this.user_id = user_id;
        this.staff = staff;
    }

    public User(int user_id, String position, Staff staff, Customer customer) {
        this.user_id = user_id;
        this.position = position;
        this.staff = staff;
        this.customer = customer;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

}
