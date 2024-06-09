test_that('P1 looks good',{
  P1 = c(60) %>% mami.codi()
  expect_true(P1$consonance_dissonance > 0)
})
test_that('P1 pure tone looks good',{
  P1 = c(60) %>% mami.codi(num_harmonics=1, verbose=T)
  expect_true(P1$consonance_dissonance > 0)
  expect_equal(P1$temporal_Sz, 0)
  expect_equal(P1$spatial_Sz, 0)
})
