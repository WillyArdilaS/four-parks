package com.project.layer.Persistence.Entity;

import java.io.Serializable;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import jakarta.persistence.AttributeOverride;
import jakarta.persistence.AttributeOverrides;
import org.hibernate.validator.constraints.Length;


@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Embeddable
@AttributeOverrides({
    @AttributeOverride(
        name = "idUser",
        column = @Column(name = "IDUSER")
    ),
    @AttributeOverride(
        name = "idDocType",
        column = @Column(name = "FK_IDDOCTYPE")
    )
})
public class UserId implements Serializable {
    @Length(min = 7, max = 12, message = "El numero de documento debe tener entre 7 y 12 caracteres")
    private String idUser;

    private String idDocType;
}