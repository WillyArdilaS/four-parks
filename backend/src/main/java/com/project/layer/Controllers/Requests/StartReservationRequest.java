package com.project.layer.Controllers.Requests;

import java.time.LocalDate;
import java.time.LocalTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class StartReservationRequest {

    private LocalDate startDateRes;

    private LocalTime startTimeRes;

    private LocalDate endDateRes;

    private LocalTime endTimeRes;

    private String licensePlate;

    private String cityId;

    private int parkingId;

    private String vehicleType;

    private Boolean isUncovered;

}
