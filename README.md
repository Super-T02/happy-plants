# Happy Plants - Never forget watering again

---

## 1. Introduction

Is a mobile flutter application for getting notifications regarding your plants.
The idea is to have different "gardens" with multiple plants. A garden can be your room / house or real garden.

Every has its own events:

1. **Watering**: It is time to water your plant! The plant is thirsty
2. **Fertilize**: You plant needs power, give her some fertilizer
3. **Spray**: Some plants need water on their skin, pleas spray them! And don't forget ist!
4. **Repot**: Plants are growing relay fast and they need their space. So repot them in certain time intervals!
5. **Dust off**: Plants living in rooms are often sad if they have dust at their skin! So please dust them of!

For all these features and for saving more data we've developed this mobile app for android.

---

## 2. Data structure

Data a plant is collecting:

- Name (```String```)
- Type (```String```)
- Size (```Own object```)
- Watering (```Own object / Event```)
- Fertilize (```Own object  / Event```)
- Spray (```Own object / Event```)
- Repot (```Own object / Event```)
- Dust off (```Own object / Event```)
- Environment (```Own object / Event```)

**Sizes** is a enum with: ```xs, s, m, l, xl``` as values
**Intervals** is a enum with: ```single, daily, weekly, monthly, yearly``` as values

This is the data structure of all events:

1. **Watering**: Needs  a interval, amount in ml and a time when the plant was watered last
2. **Fertilize**: Needs a interval, amount in mg and a time when the plant was fertilized last
3. **Spray**: Needs a interval, and the last time
4. **Repot**: Needs a interval, and the last time
5. **Dust off**: Need a interval, and the last time

*Timestamps*: All time stamps are ```Datetime``` objects.

---

## 3. About us

Developers:

- Anton Utz (*alien-coding*)
- Tom Freudenmann (*Super-T02*)
