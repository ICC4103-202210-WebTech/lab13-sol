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

    // Called when the plus button is clicked on the Event-TicketType new/edit subform.
    let add_ticket_type_form = (div_id) => {
        let timestamp = (new Date()).getTime();

        // The id of the ticket type form is unique by timestamp, so are the fields
        // in the form - see https://guides.rubyonrails.org/form_helpers.html#adding-fields-on-the-fly
        let template = `
        <div class="new-ticket-type-otf" id="new-ticket-type-${timestamp}">
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
        // See https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelector

        if (elem != null) {
            // Add a new ticket type subform.
            elem.insertAdjacentHTML("beforeend", template);
            // See https://developer.mozilla.org/en-US/docs/Web/API/Element/insertAdjacentHTML

            // GOAL (2): After the new ticket type nested form has been added, the delete button 
            // within the nested form needs a click event handler attached.

            // Follow these steps:
            // (i) Find the button that has been newly added through the insertion above (line 41).
            // Call document.querySelector passing in a selection rule that allows to find
            // an element of class 'remove-ticket-type-btn-otf' that is descendant of a div element
            // with ID `new-ticket-type-${timestamp}`

            // (ii) Call 'closest' on the button, looking for ancestor with class 'new-ticket-type-otf'.
            // (iii) If the ancestor exists, call the remove method on it.

            // References:
            // DOM API's closest method: https://developer.mozilla.org/en-US/docs/Web/API/Element/closest
            // DOM API's remove method: https://developer.mozilla.org/en-US/docs/Web/API/Element/remove
            let btn = document.querySelector(`#new-ticket-type-${timestamp} .remove-ticket-type-btn-otf`);
            btn.addEventListener('click', () => {
                let frm_tt = btn.closest('.new-ticket-type-otf');
                if (frm_tt != null) {
                    frm_tt.remove();
                }
            });
        }
    }

    let initSortButtons = () => {
        let event_lst = document.querySelector('div.event-list');
        if (event_lst) {
            document.querySelectorAll(".btn-sort-date").forEach((element) => {
                registerClickHandlerForSortButton(
                    element, 'start-date', cmpFnStartDate);
            });
            document.querySelectorAll(".btn-sort-name").forEach((element) => {
                registerClickHandlerForSortButton(
                    element, 'event-name', cmpFnEventName);
            });
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

        initSortButtons();
    });
})();