package com.cmdelivery.config.component;

import com.cmdelivery.repository.ClientRepository;
import com.cmdelivery.service.DtoService;
import com.cmdelivery.service.OTPService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import java.util.ArrayList;

@Component
@RequiredArgsConstructor(onConstructor = @__({@Autowired}))
public class ClientAuthenticationProvider implements AuthenticationProvider {

    private final ClientRepository clientRepository;
    private final OTPService otpService;

    @Override
    public Authentication authenticate(Authentication authentication)
            throws AuthenticationException {

        String phone = DtoService.parsePhone(authentication.getName());
        String password = authentication.getCredentials().toString();

        if (password.equals(Integer.toString(otpService.getOtp(phone)))) {
            otpService.clearOTP(phone);
            return new UsernamePasswordAuthenticationToken(phone, password, new ArrayList<>());
        }

        return null;
    }

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }
}
