html2canvas(document.querySelector(".chord-group")).then(canvas => {
    document.body.appendChild(canvas)
});
