describe("Product_details", () => {
  it("should visit root", () => {
    cy.visit("/");
  });

  it("should click on one of the product partials to navigate to a product detail page", () => {
    cy.visit("/");
    cy.get('img[alt="Scented Blade"]').click();
    cy.contains("Scented Blade");
    cy.get("img").should("have.attr", "src").and("include", "plante_2.jpg");
  });
});
