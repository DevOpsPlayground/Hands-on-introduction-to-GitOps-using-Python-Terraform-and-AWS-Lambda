function addTodo(itemId, itemDescription) {
    var ul = document.getElementById("todo");
    var li = document.createElement("li");
    li.setAttribute("class", "ui-state-default");
    var div = document.createElement("div");

    div.setAttribute("class", "checkbox");
    var label = document.createElement("label");

    li.setAttribute("id", itemId);

    var button = document.createElement("input");
    button.setAttribute("type", "checkbox");

    label.appendChild(button)
    label.appendChild(document.createTextNode(itemDescription));

    div.appendChild(label);
    li.appendChild(div);

    ul.appendChild(li);
}



// A $( document ).ready() block.
$(document).ready(function () {

    $("#todo").sortable();
    $("#todo").disableSelection();



    var apigClient = apigClientFactory.newClient();


    /* Initialise the lists by geting items from the API */
    apigClient.rootGet({}, {}, {})
        .then(function (result) {
            console.log(result);
            console.log(result.data)
            var i = 0;
            for (i = 0; i < result.data.length; i++) {
                console.log(result.data[i]);
                if (result.data[i].item_status == "TODO") {
                    addTodo(result.data[i].item_id, result.data[i].item_description)
                } else if (result.data[i].item_status == "INPROGRESS") {
                    inProgress(result.data[i].item_id, result.data[i].item_description)

                } else if (result.data[i].item_status == "DONE") {
                    done(result.data[i].item_id, result.data[i].item_description)

                }
            }
        }).catch(function (result) {
            console.log("An error occurred")
            console.log(result)
        });

    countTodos();

    // all done btn
    $("#checkAll").click(function () {
        AllDone();
    });

    //create todo
    $('.add-todo').on('keypress', function (e) {
        e.preventDefault
        if (e.which == 13) {
            if ($(this).val() != '') {
                var todo = $(this).val();
                var inputBox = $(this);

                apigClient.itemPost({ "Access-Control-Allow-Origin": "'*" }, { item_description: todo }, {})
                    .then(function (result) {
                        // create new item
                        addTodo(result.data.item_id, todo);

                        countTodos();

                        // reset input value
                        inputBox.val("");

                    }).catch(function (result) {
                        console.log("An error occurred")
                        console.log(result)
                    });

            } else {
                // some validation
            }
        }
    });

    // mark task as in-progress
    $('.todolist').on('change', '#todo li input[type="checkbox"]', function () {
        if ($(this).prop('checked')) {
            console.log();
            var item_ = $(this).parent().parent();
            var params = { item_id: item_.parent().attr("id") }
            console.log("IN PROGRESS ON ITEM:")
            console.log(params);
            var item = item_.find('label').text();
            var item_id = item_.parent().attr("id");

            apigClient.itemItemIdStartGet(params, {}, {})
                .then(function (result) {

                    inProgress(item_id, item);
                    countTodos();
                    removeItem(item_);

                }).catch(function (result) {
                    console.log("An error occurred")
                    console.log(result)
                });
        }
    });


    // mark task as done
    $('.todolist').on('change', '#in-progress-items li input[type="checkbox"]', function () {
        if ($(this).prop('checked')) {
            var item_ = $(this).parent().parent();
            var item_id = $(this).parent().parent().parent().attr("id");
            var doneItem = $(this).parent().parent().find('label').text();
            var params = { item_id: item_id }
            console.log("DONE ON ITEM:")
            console.log(params);
            apigClient.itemItemIdDoneGet(params, {}, {})
                .then(function (result) {
                    console.log(result);

                    done(item_id, doneItem);
                    removeItem(item_);
                    countTodos();
                }).catch(function (result) {
                    console.log("An error occurred")
                    console.log(result)
                });


        }
    });

    /* Delete an item */
    $('.todolist').on('click', '.remove-item', function () {
        var item = $(this);
        var params = { item_id: $(this).parent().attr("id") }
        console.log(params);
        apigClient.itemItemIdDelete(params, {}, {})
            .then(function (result) {
                // Delete Item 
                removeItem(item);
            }).catch(function (result) {
                console.log("An error occurred")
                console.log(result)
            });
    });
});



// count tasks
function countTodos() {
    var count = $("#todo li").length;
    $('.count-todos').html(count);
}

function inProgress(itemId, itemDescription) {
    var markup = '<li id="' + itemId + '" class="ui-state-in-progress"><div class="checkbox"><label><input type="checkbox" value="" />' + itemDescription + '</label><span class="glyphicon glyphicon-ok"></span></div></li>';

    $('#in-progress-items').append(markup);
    $('.remove').remove();
}


//mark task as done
function done(itemId, doneItem) {
    var done = doneItem;
    var markup = '<li id="' + itemId + '">' + done + '<button class="btn btn-default btn-xs pull-right  remove-item"><span class="glyphicon glyphicon-remove"></span></button></li>';
    $('#done-items').append(markup);
    $('.remove').remove();
}



//mark all tasks as done
function AllDone() {
    var myArray = [];

    $('#todo li').each(function () {
        myArray.push($(this).text());
    });

    // add to done
    for (i = 0; i < myArray.length; i++) {
        $('#done-items').append('<li>' + myArray[i] + '<button class="btn btn-default btn-xs pull-right  remove-item"><span class="glyphicon glyphicon-remove"></span></button></li>');
    }

    // myArray
    $('#todo li').remove();
    countTodos();
}

//remove done task from list
function removeItem(element) {
    $(element).parent().remove();
}