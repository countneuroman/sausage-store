package com.yandex.practicum.devops;

import com.yandex.practicum.devops.model.Product;
import com.yandex.practicum.devops.service.ProductService;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class SausageApplication {

    public static void main(String[] args) {
        SpringApplication.run(SausageApplication.class, args);
    }

    @Bean
    CommandLineRunner runner(ProductService productService) {
        return args -> {
            productService.save(new Product(1L, "Сливочная", 320.00, "https://static-std-023-61.website.yandexcloud.net/creamy_sausage.jpg"));
            productService.save(new Product(2L, "Особая", 179.00, "https://static-std-023-61.website.yandexcloud.net/special_sausage.jpg"));
            productService.save(new Product(3L, "Молочная", 225.00, "https://static-std-023-61.website.yandexcloud.net/dairy_sausage.jpg"));
            productService.save(new Product(4L, "Нюренбергская", 315.00, "https://static-std-023-61.website.yandexcloud.net/nuremberg_sausage.jpg"));
            productService.save(new Product(5L, "Мюнхенская", 330.00, "https://static-std-023-61.website.yandexcloud.net/munich_sausage.jpg"));
            productService.save(new Product(6L, "Еврейская", 189.00, "https://static-std-023-61.website.yandexcloud.net/russian_sausage.jpg"));
        };
    }
}
