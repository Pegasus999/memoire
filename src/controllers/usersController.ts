import { PrismaClient, User, Zone } from "@prisma/client";
import { Storage } from "@google-cloud/storage";
import { Request, Response } from "express";
import path from "path";

const db = new PrismaClient();
const baseUrl = "https://storage.googleapis.com/daycare-pictures/";

enum Auth {
  PARENT = "PARENT",
  ADMIN = "ADMIN",
  WORKER = "WORKER",
  DRIVER = "DRIVER",
}

const gc = new Storage({
  keyFilename: path.join(__dirname, "../config/mykey.json"),
  projectId: "hip-courier-366911",
});

export const getEmployees = async (req: Request, res: Response) => {
  try {
    const result: User[] | null = await db.user.findMany({
      where: {
        auth: {
          in: ["DRIVER", "WORKER"],
        },
      },
      include: { zone: { select: { name: true, id: true } } },
    });
    result.length
      ? res.status(200).json(result)
      : res.status(400).send("No Users Found");
  } catch (err) {
    res.status(400).send(err);
  }
};

export const getParents = async (req: Request, res: Response) => {
  try {
    const result: User[] | null = await db.user.findMany({
      where: {
        auth: "PARENT",
      },
      include: {
        zone: { select: { name: true, id: true } },
        kids: {
          include: {
            User: {
              select: {
                phone: true,
                adress: true,
                zone: { select: { name: true } },
              },
            },
          },
        },
      },
    });
    result.length
      ? res.status(200).json(result)
      : res.status(400).json({ message: "No Parents found" });
  } catch (err) {
    res.status(400).send(err);
  }
};

export const addWorker = async (req: Request, res: Response) => {
  try {
    const { username, password, name, lastname, phone, gender, job } = req.body;
    let picture: string = "";
    if (req.file) {
      const contents = req.file.buffer;
      const newName = Date.now() + req.file.originalname;

      gc.bucket("daycare-pictures")
        .file(newName)
        .save(contents)
        .catch((err) => console.log(err));
      picture = baseUrl + newName;
    } else {
      picture =
        gender == "MALE"
          ? "assets/images/MaleEmployee.png"
          : "assets/images/FemaleEmployee.png";
    }

    const result: User | null = await db.user.create({
      data: {
        username,
        password,
        name,
        lastname,
        job,
        phone,
        picture,
        gender,
        auth: "WORKER",
      },
    });
    console.log(result);

    result
      ? res.status(200).json({ result, message: "تم اضافة الحساب" })
      : res.status(400).send("An error occured");
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};

export const addDriver = async (req: Request, res: Response) => {
  try {
    const { username, password, name, lastname, phone, gender, zone } =
      req.body;
    let picture: string = "";
    if (req.file) {
      const contents = req.file.buffer;
      const newName = Date.now() + req.file.originalname;

      gc.bucket("daycare-pictures")
        .file(newName)
        .save(contents)
        .catch((err) => console.log(err));
      picture = baseUrl + newName;
    } else {
      picture = "assets/images/Driver.png";
    }

    const result: User | null = await db.user.create({
      data: {
        username,
        password,
        name,
        lastname,
        zone: { connect: { name: zone } },
        phone,
        picture,
        job: "سائق",
        gender,
        auth: "DRIVER",
      },
    });
    console.log(result);

    result
      ? res.status(200).json({ result, message: "Driver created" })
      : res.status(400).send("An error occured");
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};

export const addParent = async (req: Request, res: Response) => {
  try {
    const { username, password, name, lastname, phone, adress, gender, zone } =
      req.body;
    let picture: string = "";
    if (req.file) {
      const contents = req.file.buffer;
      const newName = Date.now() + req.file.originalname;

      gc.bucket("daycare-pictures")
        .file(newName)
        .save(contents)
        .catch((err) => console.log(err));
      picture = baseUrl + newName;
    } else {
      picture =
        gender == "MALE"
          ? "assets/images/MaleParent.png"
          : "assets/images/FemaleParent.png";
    }

    const result: User | null = await db.user.create({
      data: {
        username,
        password,
        adress,
        name,
        lastname,
        phone,
        picture,
        zone: { connect: { name: zone } },
        gender,
        auth: "PARENT",
      },
      include: { zone: true },
    });
    console.log(result);

    result
      ? res.status(200).json({ result, message: "Parent created" })
      : res.status(400).send("An error occured");
  } catch (err) {
    console.log(err);
    res.status(400).send(err);
  }
};

export const getZones = async (req: Request, res: Response) => {
  try {
    const result: Zone[] | null = await db.zone.findMany({});
    result.length
      ? res.status(200).json(result)
      : res.status(400).send("No Zones");
  } catch (err) {
    res.status(400).send(err);
  }
};
