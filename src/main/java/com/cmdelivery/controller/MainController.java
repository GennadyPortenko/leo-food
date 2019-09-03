package com.cmdelivery.controller;

import com.cmdelivery.dto.SectionDto;
import com.cmdelivery.exception.Error404Exception;
import com.cmdelivery.model.Contractor;
import com.cmdelivery.repository.CategoryRepository;
import com.cmdelivery.repository.ContractorRepository;
import com.cmdelivery.service.DtoService;
import com.cmdelivery.service.SectionService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequiredArgsConstructor(onConstructor = @__({@Autowired}))
public class MainController {
    private final ContractorRepository contractorRepository;
    private final CategoryRepository categoryRepository;
    private final DtoService dtoService;

    @RequestMapping(value="/food", method={ RequestMethod.GET, RequestMethod.POST })
    public ModelAndView food() {
        ModelAndView modelAndView = new ModelAndView("client/food");
        modelAndView.addObject("restaurants",
                contractorRepository.findAll().stream().map(dtoService::convertToDto).collect(Collectors.toList()));
        modelAndView.addObject("categories", categoryRepository.findAll());
        return modelAndView;
    }

    @GetMapping(value="/food/restaurant/{restaurantName}")
    public ModelAndView restaurant(@PathVariable String restaurantName) {
        Contractor restaurant = contractorRepository.findByName(restaurantName);
        if (restaurant == null) {
            throw new Error404Exception();
        }
        ModelAndView modelAndView = new ModelAndView("client/restaurant");
        modelAndView.addObject("restaurant", dtoService.convertToDto(restaurant));
        return modelAndView;
    }

}
