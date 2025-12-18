package pl.bogudal.mikolaj.GatewayWithKeycloak.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;

@EnableWebFluxSecurity
public class SecurityConfiguration {
    @Bean
    public SecurityWebFilterChain securityWebFilterChain(ServerHttpSecurity http) {
        return http
                .csrf(ServerHttpSecurity.CsrfSpec::disable)
                .authorizeExchange(exchanges -> exchanges
                        .pathMatchers("/public/**").permitAll() // opcjonalne publiczne endpointy
                        // Endpointy webowe → logowanie OAuth2 (redirect do Keycloak)
                        .pathMatchers("/web/**").authenticated()

                        // Endpointy API → weryfikacja JWT
                        .pathMatchers("/api/**").authenticated()
                )
                // Logowanie dla web / przeglądarki
                .oauth2Login(Customizer.withDefaults())

                // Resource Server dla API / weryfikacja tokena
                .oauth2ResourceServer(oauth2 -> oauth2.jwt(Customizer.withDefaults()))      // <- redirect do Keycloak
                .build();
    }
}
