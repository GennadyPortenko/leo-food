package com.cmdelivery.dto;

import com.cmdelivery.model.Product;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SectionDto {
    int id;
    String name;
    String description;
    List<ProductDto> products;
}