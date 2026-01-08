package com.eventsphere.model;

public class Event {
    private int eventId;
    private String eventName;
    private String description;
    private String event_date;
    private String venue;
    private String coordinator_name;
    private String coordinator_email;
    private String coordinator_phone;
    private boolean isUpcoming;

    public Event() {}

    public Event(String eventName, String description, String event_date, String venue, String coordinator_name,
                 String coordinator_email, String coordinator_phone, boolean isUpcoming) {
        this.eventName = eventName;
        this.description = description;
        this.event_date = event_date;
        this.venue = venue;
        this.coordinator_name = coordinator_name;
        this.coordinator_email = coordinator_email;
        this.coordinator_phone = coordinator_phone;
        this.isUpcoming = isUpcoming;
    }

    // Getters and Setters
    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getEvent_date() {
        return event_date;
    }

    public void setEvent_date(String event_date) {
        this.event_date = event_date;
    }

    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getCoordinator_name() {
        return coordinator_name;
    }

    public void setCoordinator_name(String coordinator_name) {
        this.coordinator_name = coordinator_name;
    }

    public String getCoordinator_email() {
        return coordinator_email;
    }

    public void setCoordinator_email(String coordinator_email) {
        this.coordinator_email = coordinator_email;
    }

    public String getCoordinator_phone() {
        return coordinator_phone;
    }

    public void setCoordinator_phone(String coordinator_phone) {
        this.coordinator_phone = coordinator_phone;
    }

    public boolean getIsUpcoming() {
        return isUpcoming;
    }

    public void setIsUpcoming(boolean isUpcoming) {
        this.isUpcoming = isUpcoming;
    }
}
