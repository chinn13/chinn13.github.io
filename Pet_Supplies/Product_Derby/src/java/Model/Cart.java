package Model;

public class Cart {

    private int cart_id;
    private Product product;
    private int qty;
    private User user;

    public Cart() {
    }

    public Cart(int cart_id, int qty, User user) {
        this.cart_id = cart_id;
        this.qty = qty;
        this.user = user;
    }

    public Cart(int cart_id, Product product, int qty, User user) {
        this.cart_id = cart_id;
        this.product = product;
        this.qty = qty;
        this.user = user;
    }

    public int getCart_id() {
        return cart_id;
    }

    public void setCart_id(int cart_id) {
        this.cart_id = cart_id;
    }

    public Product getProduct() { // Updated getter
        return product;
    }

    public void setProduct(Product product) { // Updated setter
        this.product = product;
    }

    public int getQty() {
        return qty;
    }

    public void setQty(int qty) {
        this.qty = qty;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

}
