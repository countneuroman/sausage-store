using Microsoft.EntityFrameworkCore;
using SausageApplication.Models;

namespace SausageApplication.Infrastructure;

public class SausageContext : DbContext
{
    public DbSet<Product> Products { get; set; }
    public DbSet<Order> Orders { get; set; }

    public SausageContext(DbContextOptions<SausageContext> options, IConfiguration configuration) : base(options)
    {
    }
    
    protected override void OnModelCreating(ModelBuilder builder)
    {
        builder.Entity<Product>(p =>
        {
            p.HasKey(e => e.Id);
            p.Property(e => e.Id).HasColumnName("id").ValueGeneratedOnAdd();
            p.HasIndex(e => e.Id);
            p.Property(e => e.Name).IsRequired().HasColumnName("name");
            p.Property(e => e.Price).HasColumnName("price");
            p.Property(e => e.PictureUrl).HasColumnName("picture_url");
            p.HasMany(e => e.Orders).WithMany(e => e.Products)
                .UsingEntity<OrderProduct>(e => e.Property(s => s.Quantity));
        });
        
        builder.Entity<Order>(p =>
        { 
            p.HasKey(e => e.Id);
            p.HasIndex(e => e.Id);
            p.Property(e => e.Id).HasColumnName("id").ValueGeneratedOnAdd();
            p.Property(e => e.Status).HasColumnName("status");
            p.Property(e => e.DateCreated).HasColumnName("date_created")
                .HasDefaultValueSql("current_date");
            p.HasMany(e => e.Products).WithMany(e => e.Orders)
                .UsingEntity<OrderProduct>(e => e.Property(s => s.Quantity));
        });

        builder.Entity<OrderProduct>(p =>
        {
            p.Property(e => e.Quantity).HasColumnName("quantity");
            p.Property(e => e.ProductId).HasColumnName("product_id");
            p.Property(e => e.OrderId).HasColumnName("order_id");
            p.HasIndex(e => new {e.ProductId, e.OrderId});
        });
    }
}