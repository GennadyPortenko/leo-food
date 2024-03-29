package com.cmdelivery.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;


@NoArgsConstructor
@RequiredArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ProductDto {
    @NonNull long id;
    String name;
    String description;
    String image;
}
