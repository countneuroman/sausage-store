namespace SausageApplication.Models;

public class Product
{
    public long Id { get; set; }
    public string Name { get; set; }
    public double Price { get; set; }
    public string PictureUrl { get; set; }
    
    public List<Order> Orders { get; } = new();
    public List<OrderProduct> OrderProducts { get; } = new();
    
}