(() => {
    // The following functions use the object destructuring technique
    // introduced by ES6 for function parameters.
    // See here: https://simonsmith.io/destructuring-objects-as-function-parameters-in-es6
    let cmpFnStartDate = ({ dataset: { startDate: a } }, { dataset: { startDate: b } }) => a.localeCompare(b);
    let cmpFnEventName = ({ dataset: { eventName: a } }, { dataset: { eventName: b } }) => a.localeCompare(b);

    // The first parameter is a button object, the second parameter is the
    // data attribute (i.e., start-date or event-name) by which events should be sorted,
    // compareFn is a function that permits comparing dates or event names (i.e., see the
    // two functions defined above...).
    let registerClickHandlerForSortButton = (btn, dataAtt, compareFn) => {
        btn.addEventListener('click', ev => {
            Array.from(document.querySelectorAll(`div.event-list > div[data-${dataAtt}]`))
                .sort(compareFn)
                .forEach((item) => item.parentNode.appendChild(item));
        });
    }

    let add_ticket_type_form = (div_id) => {
        let timestamp = (new Date()).getTime();
        let template = `
        <div class="new-ticket-type-otf">
            <div class="mb-3">
                <label for="event_ticket_types_attributes_${timestamp}_name">Name</label>
                <input class="form-control" type="text" name="event[ticket_types_attributes][${timestamp}][name]" id="event_ticket_types_attributes_${timestamp}_name" />
            </div>
            <div class="mb-3">
                <label for="event_ticket_types_attributes_${timestamp}_price">Price</label>
                <input class="form-control" type="text" name="event[ticket_types_attributes][${timestamp}][price]" id="event_ticket_types_attributes_${timestamp}_price" />
            </div>
            <div class="mb-3">
                <button type="button" class="btn btn-danger remove-ticket-type-btn-otf">
                    <i class="far fa-minus-square"></i>
                </button>
            </div>
            <hr>
        </div>`;
        let elem = document.querySelector(`#${div_id}`);
        if (elem != null) {
            elem.insertAdjacentHTML("beforeend", template);
        }
    }

    document.addEventListener("turbo:load", (ev) => {
        // A handler is added to the "Add Ticket Type" button, so that
        // when clicked, a new sub-form is appended to the event creation/edition
        // from.
        let add_tt_btn = document.querySelector('#btn_add_ticket_type');
        if (add_tt_btn != null) {
            add_tt_btn.addEventListener('click', (e) => {
                add_ticket_type_form('ticket_types_add_form');
            });
        }

        // TODO: COMPLETE THIS FUNCTION!
        // GOAL (1): Add behavior to the buttons that permit sorting events by
        // start date and name in the home page and events#index views.

        // This function is an event handler for the "turbo:load" event,
        // which is triggered when the current page finishes loading.

        // You must complete this function with the following steps:
        // 1. Use the DOM API to find/get a div object with class 'event-list'
        // 2. If such an object exists, then, use the DOM API to find
        // the buttons meant to sort events by date and name. See the
        // partial at /app/views/events/_event_sort_controls.html.erb
        // to find out the IDs of both buttons.
        // 3. Use the registerClickHandlerForSortButton function defined
        // above so that each button sorts the events by start date and
        // event name. The second parameter of this function tells the
        // name of the data attribute containing the field by which events
        // will be sorted, e.g., "start-date". The name of the data
        // attribute does not require the "data" prefix in this case.

        // GOAL (2): Add behavior to buttons of class 'remove-ticket-type-btn-otf',
        // so that when a button of such class is pressed, the
        // Ticket Type creation form where it appears is removed from the
        // DOM.

    });
})();